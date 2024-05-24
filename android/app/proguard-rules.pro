# Flutter wrapper classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }

# Flutter packages
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }

# Firebase packages
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# HTTP package
-keep class io.flutter.plugins.** { *; }
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# Retrofit (if used)
-keep class retrofit2.** { *; }
-keep class com.google.gson.** { *; }
-keep class javax.annotation.** { *; }

# Gson (if used)
-keep class com.google.gson.** { *; }
-keep class com.google.gson.annotations.** { *; }

# Glide (if used)
-keep class com.bumptech.glide.** { *; }
-keep class com.bumptech.glide.** { *; }
-dontwarn com.bumptech.glide.**

# Lottie
-keep class com.airbnb.lottie.** { *; }

# TFLite
-keep class org.tensorflow.lite.** { *; }

# Avoid obfuscating model classes (if any)
-keep class com.example.yourapp.models.** { *; }

# Required for Google Play services
-keep class com.google.android.gms.common.api.** { *; }

# Enable for debugging
-keepattributes SourceFile,LineNumberTable

# Retain annotation information for libraries that use reflection.
-keepattributes *Annotation*

# Keep generic type information for Gson
-keepattributes Signature

# Keep enums
-keepclassmembers enum * { *; }

# Keep the class name for serialized classes.
-keepnames class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep inner classes
-keepattributes InnerClasses

# Keep the value of the class annotations
-keep @interface * {
    *;
}

# Support for Firebase Auth
-keepclassmembers class * {
    @com.google.firebase.auth.FirebaseAuthRegistrar <fields>;
}
-keep class com.google.firebase.auth.** { *; }
-keep class com.google.android.gms.internal.firebase_auth.** { *; }

# Keep the Firebase firestore classes
-keep class com.google.firebase.firestore.** { *; }
-keep class com.google.firebase.firestore.model.** { *; }
-keep class com.google.firebase.firestore.local.** { *; }
-keep class com.google.firebase.firestore.remote.** { *; }
-keep class com.google.firebase.firestore.core.** { *; }

# Keep the Firebase storage classes
-keep class com.google.firebase.storage.** { *; }

# Keep the Firebase messaging classes
-keep class com.google.firebase.messaging.** { *; }

# Keep the Firebase database classes
-keep class com.google.firebase.database.** { *; }

# Add rules for any other libraries you use
