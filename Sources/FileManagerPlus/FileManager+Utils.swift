//
//  Utils.swift
//  FoundationPlus
//
//  Created by Star_Lord_PHB on 2024/7/31.
//

import Foundation
import ConcurrencyPlus


@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension FileManager {
    
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS) || os(visionOS)

    @available(macOS, deprecated: 15.0)
    @available(iOS, deprecated: 18.0)
    @available(watchOS, deprecated: 11.0)
    @available(tvOS, deprecated: 18.0)
    @available(visionOS, deprecated: 2.0)
    public static func runOnIOQueue<R>(
        _ operation: @escaping () throws -> R
    ) async throws -> R {
        if #available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *) {
            try await withTaskExecutorPreference(.defaultExecutor.io, operation: { try operation() })
        } else {
            try await launchTask(on: .io, operation: operation)
        }
    }
    
    
    @available(macOS, deprecated: 15.0)
    @available(iOS, deprecated: 18.0)
    @available(watchOS, deprecated: 11.0)
    @available(tvOS, deprecated: 18.0)
    @available(visionOS, deprecated: 2.0)
    public static func runOnIOQueue<R>(
        _ operation: @escaping () -> R
    ) async -> R {
        if #available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *) {
            await withTaskExecutorPreference(.defaultExecutor.io, operation: { operation() })
        } else {
            await launchTask(on: .io, operation: operation)
        }
    }

#endif
    
    
    public static func assertOnIOQueue() {
        dispatchPrecondition(condition: .onQueue(DefaultTaskExecutor.io.queue))
    }
    
}



@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension FileManager {

    public static func runOnIOQueue<R>(operation: () throws -> R) async rethrows -> R {
        try await withTaskExecutorPreference(.defaultExecutor.io) {  
            try operation() 
        }
    }

}