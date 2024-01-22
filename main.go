package main

import (
	"github.com/gin-gonic/gin"
	_ "go.uber.org/automaxprocs"
)

func main() {
	router := gin.Default()
	applyRoutes(router)
	router.Run(":8080")
}

func applyRoutes(router *gin.Engine) {
	router.GET("/", func(c *gin.Context) {
		c.String(200, "Greetings from Felix!")
	})
}
