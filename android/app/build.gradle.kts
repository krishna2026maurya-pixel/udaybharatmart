plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}
android {
    namespace = "com.ziplymart.ziplyuserapp"
    compileSdk = 36
    signingConfigs {
        create("release") {
            storeFile = file("upload-keystore.jks")
            storePassword = "${System.getenv("storePassword")}"
            keyAlias = "${System.getenv("keyAlias")}"
            keyPassword = "${System.getenv("keyPassword")}"
        }
    }
    defaultConfig {
        applicationId = "com.ziplymart.ziplyuserapp"
        minSdk = 26
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
    packagingOptions {
        jniLibs.useLegacyPackaging = true
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}
flutter {
    source = "../.."
}
