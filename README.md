# Aqsis Setup Instructions

## STEP 1 Build the Docker Image
First, build the Linux environment and install Aqsis and its dependencies:
### Command to Run:
`docker build -t aqsis-builder .`

## STEP 2 - Option 1: Run Aqsis Without External Display
This option runs Aqsis without using an external display. You won't be able to generate the framebuffer for real-time image building. Instead, you can add a Display line at the top of your .rib file like:
#Display "example.png" "file" "rgba"
#and just open up the .png 
### Command to Run:
`docker run -it -v $(pwd):/workspace /bin/bash`


## STEP 2 - Option 2: Connect an External Display
This option connects an external display to the container, allowing you to visualize the rendered framebuffer.

### Command to Run:
`docker run -it -v $(pwd):/workspace --env DISPLAY=host.docker.internal:0  aqsis-builder /bin/bash`

## Step 3: Verify the Setup

run `ls` and make sure you can see the Dockerfile, example.rib, and the README.md
then run
`aqsis example.rib`

you'll see an example.png on your machine get created and the framebuffer showing if set up correctly