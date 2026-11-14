
import java.util.Properties
import org.gradle.api.GradleException

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

// --------------------------------------------------
// Release Signing Configuration
// --------------------------------------------------

val keystoreProperties = Properties()

// Location: android/key.properties
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { input ->
        keystoreProperties.load(input)
    }
}

val releaseStoreFilePath =
    keystoreProperties.getProperty("storeFile")

val releaseStorePasswordValue =
    keystoreProperties.getProperty("storePassword")

val releaseKeyAliasValue =
    keystoreProperties.getProperty("keyAlias")

val releaseKeyPasswordValue =
    keystoreProperties.getProperty("keyPassword")

val releaseStoreFile = releaseStoreFilePath
    ?.takeIf { it.isNotBlank() }
    ?.let { file(it) }

// All credentials and the actual keystore file must exist.
val releaseSigningReady =
    releaseStoreFile?.isFile == true &&
    !releaseStorePasswordValue.isNullOrBlank() &&
    !releaseKeyAliasValue.isNullOrBlank() &&
    !releaseKeyPasswordValue.isNullOrBlank()

// Prevent accidentally generating an unsigned Release APK.
val releaseTaskRequested = gradle.startParameter.taskNames.any {
    it.substringAfterLast(":").contains("release", ignoreCase = true)
}

if (releaseTaskRequested && !releaseSigningReady) {
    throw GradleException(
        """
        Sintir Release signing is not configured correctly.

        Please check:
        1. android/key.properties exists.
        2. storeFile points to an existing .jks file.
        3. storePassword is correct.
        4. keyAlias is correct.
        5. keyPassword is correct.
        """.trimIndent()
    )
}

// --------------------------------------------------
// Android Configuration
// --------------------------------------------------

android {
    namespace = "com.example.sintir"

    compileSdk = 37
    ndkVersion = "28.2.13676358"

    // --------------------------------------------------
    // Signing Configurations
    // --------------------------------------------------

    signingConfigs {
        if (releaseSigningReady) {
            create("release") {
                storeFile = requireNotNull(releaseStoreFile)
                storePassword = requireNotNull(releaseStorePasswordValue)
                keyAlias = requireNotNull(releaseKeyAliasValue)
                keyPassword = requireNotNull(releaseKeyPasswordValue)
            }
        }
    }

    // --------------------------------------------------
    // Compile Options
    // --------------------------------------------------

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    // --------------------------------------------------
    // Default Configuration
    // --------------------------------------------------

    defaultConfig {
        applicationId = "com.example.sintir"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // --------------------------------------------------
    // Build Types
    // --------------------------------------------------

    buildTypes {

        // Release Configuration
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = false

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            // Never use the Debug signing identity for Release.
            signingConfig = if (releaseSigningReady) {
                signingConfigs.getByName("release")
            } else {
                null
            }
        }

        // Debug Configuration
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false

            // Use Android's automatically generated Debug keystore.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// --------------------------------------------------
// Kotlin Configuration
// --------------------------------------------------

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// --------------------------------------------------
// Flutter Configuration
// --------------------------------------------------

flutter {
    source = "../.."
}

// --------------------------------------------------
// Dependencies
// --------------------------------------------------

dependencies {
    implementation("androidx.media3:media3-exoplayer:1.5.1")

    implementation("com.facebook.android:facebook-login:latest.release")
}
