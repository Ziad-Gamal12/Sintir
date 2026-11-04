plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

val releaseStoreFilePath = providers.environmentVariable("SINTIR_RELEASE_STORE_FILE").orNull
val releaseStorePasswordValue = providers.environmentVariable("SINTIR_RELEASE_STORE_PASSWORD").orNull
val releaseKeyAliasValue = providers.environmentVariable("SINTIR_RELEASE_KEY_ALIAS").orNull
val releaseKeyPasswordValue = providers.environmentVariable("SINTIR_RELEASE_KEY_PASSWORD").orNull
val releaseSigningReady = listOf(
    releaseStoreFilePath,
    releaseStorePasswordValue,
    releaseKeyAliasValue,
    releaseKeyPasswordValue,
).all { !it.isNullOrBlank() }

android {
    namespace = "com.example.sintir"
    compileSdk = 37
    ndkVersion = "28.2.13676358"

    if (releaseSigningReady) {
        signingConfigs {
            create("release") {
                storeFile = file(requireNotNull(releaseStoreFilePath))
                storePassword = requireNotNull(releaseStorePasswordValue)
                keyAlias = requireNotNull(releaseKeyAliasValue)
                keyPassword = requireNotNull(releaseKeyPasswordValue)
            }
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.example.sintir"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = false

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            // An unset release key produces an unsigned artifact; never fall
            // back to the debug identity for a release build.
            signingConfig = if (releaseSigningReady) {
                signingConfigs.getByName("release")
            } else {
                null
            }
        }

        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

kotlin {
      compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.media3:media3-exoplayer:1.5.1")
    implementation("com.facebook.android:facebook-login:latest.release")
}
