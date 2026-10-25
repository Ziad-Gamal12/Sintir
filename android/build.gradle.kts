allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = File("../build")

subprojects {
    project.buildDir = File(rootProject.buildDir, project.name)

    if (name == "better_player_plus") {
        // This plugin targets Java 17, but AGP 9 otherwise defaults its Kotlin
        // task to the running JDK. Keep its Kotlin bytecode aligned locally.
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
            compilerOptions.jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }
}

tasks.register("clean") {
    delete(rootProject.buildDir)
}
