# --- FIX for Firebase Storage R8 Missing Classes ---
-keep class io.flutter.plugins.firebase.storage.** { *; }
-dontwarn io.flutter.plugins.firebase.storage.**
-keep class com.google.firebase.storage.** { *; }
-dontwarn com.google.firebase.storage.**
-keep class androidx.annotation.Keep
-keep class * extends androidx.room.RoomDatabase { <init>(); }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
-keep class androidx.work.** { *; }
-keep class androidx.startup.** { *; }