plugins {
    //trick: for the same plugin versions in all sub-modules
    id("com.android.application").version("8.0.0-alpha04").apply(false)
    id("com.android.library").version("8.0.0-alpha04").apply(false)
    kotlin("android").version("1.7.20").apply(false)
    kotlin("multiplatform").version("1.7.20").apply(false)
    kotlin("plugin.serialization").version("1.7.20").apply(false)

}


buildscript {
    dependencies {
        classpath("com.squareup.sqldelight:gradle-plugin:1.5.3")
    }
}


tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
