# fingerd

Probably the most useless Dockerfile I've ever created. This Dockerfile builds an image that runs `xinetd`, which is used to serve `fingerd`.

How to use it:

- Add some users under the `home/` directory in this repository, change the `.plan` files to something interesting.

- Build the Docker image

  ```sh
  docker build -t ricardobalk/finger .
  ```

- Run the Docker image in a container, making sure to forward port 79.
  
  ```sh
  docker run -p 79:79 -d ricardobalk/finger
  ```

- Try to use `finger bob@localhost` (or one of your own created users).

- Stop the Docker container when finished playing.

That's it.
