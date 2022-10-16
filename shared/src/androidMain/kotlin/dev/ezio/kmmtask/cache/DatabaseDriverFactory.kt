package dev.ezio.kmmtask.cache


import android.content.Context
import com.squareup.sqldelight.android.AndroidSqliteDriver
import com.squareup.sqldelight.db.SqlDriver
import dev.ezio.kmmtask.sqldelight.database.TaskDatabase

actual class DatabaseDriverFactory(private val context: Context)  {
    actual fun createDriver(): SqlDriver {
        return AndroidSqliteDriver(TaskDatabase.Schema, context, "test.db")
    }
}