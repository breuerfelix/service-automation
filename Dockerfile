# Use the official Golang image as the base image
FROM golang:1.21-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go modules files
COPY go.mod .
COPY go.sum .

# Download and install Go dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go application
RUN go build -o app

# Use a minimal Alpine image as the base image for the final image
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the built executable from the builder image
COPY --from=builder /app/app .

# Expose the port that the application will run on
EXPOSE 8080

# Command to run the application
CMD ["./app"]
