plugins {
    id("com.android.application")
}

android {
    namespace = "local.mio.os4camerabridge"
    compileSdk = 36

    defaultConfig {
        applicationId = namespace
        minSdk = 30
        targetSdk = 36
        versionCode = 187
        versionName = "0.4.77-motion-60fps"

        ndk {
            abiFilters += listOf("arm64-v8a")
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }
}

dependencies {
    implementation("org.luckypray:dexkit:2.2.0")
    compileOnly("de.robv.android.xposed:api:82")
    implementation("org.tensorflow:tensorflow-lite:2.17.0")
}
