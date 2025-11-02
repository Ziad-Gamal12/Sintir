# --- FIX for Firebase Storage R8 Missing Classes ---
-keep class io.flutter.plugins.firebase.storage.** { *; }
-dontwarn io.flutter.plugins.firebase.storage.**
-keep class com.google.firebase.storage.** { *; }
-dontwarn com.google.firebase.storage.**
-keep class androidx.annotation.Keep
