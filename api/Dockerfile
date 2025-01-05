# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./

COPY --chown=node:node yarn.lock ./

# Install Yarn globally
RUN npm install -g yarn

# Install the application dependencies
RUN yarn install

# Copy the rest of the application code to the working directory
COPY . .

# Expose port 3000 for the application
EXPOSE 3000

# Command to run your application
CMD ["make", "start:prod"]
