package dev.ezio.kmmtask

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform