FROM node:20.11.1-alpine

WORKDIR /app

# Install dependencies
COPY package*.json ./

RUN npm install

# Copy source code
COPY . .

# Expose port
EXPOSE 3000

# Keep container running for development
CMD ["tail", "-f", "/dev/null"]
