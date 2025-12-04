
plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") 
}

android {
    namespace = "com.example.sintir"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
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

        signingConfig = signingConfigs.getByName("debug")
    }

    getByName("debug") {
        isMinifyEnabled = false
        isShrinkResources = false
    }
    
}
}

flutter {
    source = "../.."
}
dependencies {
    implementation("androidx.media3:media3-exoplayer:1.5.1")
    implementation("com.facebook.android:facebook-login:latest.release")
}
