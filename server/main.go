package main

import (
	"os"

	"github.com/gofiber/fiber/v2"
)

func main() {
	app := fiber.New()

	app.Get("/locations", func(c *fiber.Ctx) error {

		rawData, err := os.ReadFile("./data.json")
		if err != nil {
			return err
		}
		c.Context().SetContentType(fiber.MIMEApplicationJSON)
		return c.Send(rawData)
	})

	app.Listen(":3000")
}
