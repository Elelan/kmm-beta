package dev.ezio.kmmtask

import io.ktor.client.HttpClient
import io.ktor.client.request.get
import io.ktor.client.statement.bodyAsText

class Greeting {
    private val platform: Platform = getPlatform()
    private val client = HttpClient()

    fun greeting(): String {
        return "Hello, ${platform.name}!"
    }

    suspend fun secondGreeting(): String {

        val response = client.get("https://ktor.io/docs/")
        return response.bodyAsText()
    }

}