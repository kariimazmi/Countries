//
//  GetCurrentCountryUseCase.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//


import CoreLocation

final class GetCurrentCountryUseCase: NSObject, GetCurrentCountryUseCaseContract {
    private enum LocationError: Error {
        case failedToGetLocation
    }
    
    private let locationManager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocation, Error>?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    @MainActor
    func execute() async throws -> String {
        do {
            let location = try await requestLocation()
            let countryCode = try await reverseGeocode(location: location)
            return countryCode
        } catch {
            return "EG"
        }
    }
}

private extension GetCurrentCountryUseCase {
    @MainActor
    func requestLocation() async throws -> CLLocation {
        locationManager.requestWhenInUseAuthorization()

        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            locationManager.requestLocation()
        }
    }

    func reverseGeocode(location: CLLocation) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if let countryCode = placemarks?.first?.isoCountryCode {
                    continuation.resume(returning: countryCode)
                } else {
                    continuation.resume(throwing: LocationError.failedToGetLocation)
                }
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension GetCurrentCountryUseCase: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            continuation?.resume(returning: location)
            continuation = nil
        } else {
            continuation?.resume(throwing: LocationError.failedToGetLocation)
            continuation = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}
