//
//  AppDependencyProvider.swift
//  DuckDuckGo
//
//  Copyright © 2018 DuckDuckGo. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import Core
import BrowserServicesKit

protocol DependencyProvider {
    var appSettings: AppSettings { get }
    var variantManager: VariantManager { get }
    var featureFlagger: FeatureFlagger { get }
    var featureFlaggerInternalUserDecider: FeatureFlaggerInternalUserDecider { get }
    var remoteMessagingStore: RemoteMessagingStore { get }
    var homePageConfiguration: HomePageConfiguration { get }
    var storageCache: StorageCacheProvider { get }
    var voiceSearchHelper: VoiceSearchHelperProtocol { get }
    var downloadManager: DownloadManager { get }
    var autofillLoginSession: AutofillLoginSession { get }
}

/// Provides dependencies for objects that are not directly instantiated
/// through `init` call (e.g. ViewControllers created from Storyboards).
class AppDependencyProvider: DependencyProvider {
    static var shared: DependencyProvider = AppDependencyProvider()
    
    let appSettings: AppSettings = AppUserDefaults()
    let variantManager: VariantManager = DefaultVariantManager()
    
    private let defaultFeatureFlagger = DefaultFeatureFlagger()
    var featureFlagger: FeatureFlagger {
        return defaultFeatureFlagger
    }
    var featureFlaggerInternalUserDecider: FeatureFlaggerInternalUserDecider {
        return defaultFeatureFlagger
    }

    let remoteMessagingStore: RemoteMessagingStore = RemoteMessagingStore()
    lazy var homePageConfiguration: HomePageConfiguration = HomePageConfiguration(variantManager: variantManager,
                                                                                  remoteMessagingStore: remoteMessagingStore)
    let storageCache = StorageCacheProvider()
    let voiceSearchHelper: VoiceSearchHelperProtocol = VoiceSearchHelper()
    let downloadManager = DownloadManager()
    let autofillLoginSession = AutofillLoginSession()
}
