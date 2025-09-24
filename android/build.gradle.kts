// android/build.gradle.kts

buildscript {
    val kotlin_version by extra("2.1.0")

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = File("../build")

subprojects {
    project.buildDir = File(rootProject.buildDir, project.name)
    project.evaluationDependsOn(":app")
}

tasks.register("clean") {
    delete(rootProject.buildDir)
}
