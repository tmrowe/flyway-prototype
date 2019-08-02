package com.prototype.flyway

import org.flywaydb.core.Flyway

open class Application {

    companion object Main {
        @JvmStatic
        fun main(args: Array<String>) {
            val username = "flyway_migration"
            val password = "123456"

            val flyway = Flyway.configure()
                .dataSource("jdbc:postgresql://localhost:5432/flyway", username, password)
                .load()

            flyway.migrate()
        }
    }

}
