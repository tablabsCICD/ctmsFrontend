# Keep Flutter classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-dontwarn io.flutter.embedding.**

# Keep model classes (replace with your package)
-keep class com.devsnik.flutter_hr_management.models.** { *; }
-keepclassmembers class com.yourpackage.models.** { *; }

# Keep JSON models (important for serialization)
-keep class com.yourpackage.models.** { *; }
-keepclassmembers class com.yourpackage.models.** {
    <fields>;
    <methods>;
}

# Keep annotations
-keepattributes *Annotation*

# Keep Gson/JsonSerializable reflection-based parsing
-keep class com.google.gson.** { *; }
-keep class com.fasterxml.jackson.** { *; }

# Retrofit/OkHttp if you use them
-dontwarn okhttp3.**
-keep class okhttp3.** { *; }
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }

# Keep generated adapters (json_serializable / hive etc.)
-keep class *.GeneratedAdapter { *; }
-keep class *JsonAdapter { *; }

# Suppress warnings about meta-inf
-dontwarn javax.annotation.**

# Keep Retrofit / Dio classes if used
-keep interface com.devsnik.flutter_hr_management.api.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn retrofit2.**
-dontwarn com.google.gson.**

# Prevent stripping of annotations
-keepattributes Signature
-keepattributes *Annotation*
