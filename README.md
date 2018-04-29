# docker-nutanix-cli
Dockerfile to build a container image for the Nutanix Command-Line Interface (nCLI)

## Dependencies
- Internet
- Docker CE or EE
- ncli.zip (download it via Prism)

## Cloning the repo
Clone this repo and move into the directory
```bash
$ git clone https://github.com/pipoe2h/docker-nutanix-cli.git
$ cd docker-nutanix-cli
```

## Downloading the Nutanix CLI
Download the **ncli.zip** file from Prism and save it into the repo folder.

```bash
$ ls docker-nutanix-cli
Dockerfile      README.md       ncli.zip
```

## Building the Docker image
To build the image run the following command within the repo directory. I have used the tag latest, feel free to use your own tagging.

```bash
$ docker build . -t ncli:latest
```

## Testing the image
To test this image you need access to a CVM.

Also, this image uses variables to pass the required values:
- NTNX_IP (CVM or cluster IP)
- NTNX_USERNAME (UI username)
- NTNX_PASSWORD (UI password)

```bash
$ docker run -it --rm -e NTNX_IP=192.168.1.1 -e NTNX_USERNAME=admin -e NTNX_PASSWORD=nutanix/4u ncli:latest


Welcome, admin
You're now connected to 00000afa-0b00-0a0e-000c-0000000000a0 (JoseGomez.io) at 192.168.1.1
```
The arguments used are:
- -it (Interactive + Allocate a pseudo-TTY)
- --rm (Automatically remove the container when it exits)
- -e (Set environment variables)

## Recommendations
Create a dedicated folder where you can save the credentials for each of your Nutanix clusters on its own file. This example shows a single cluster (*cluster1*), but you can repeat the same steps for multiple clusters. Also, remember to set the permissions of your credential files to 600 so only you have read/write access.

```bash
$ mkdir credentials
$ cd credentials
$ cat <<EOF> cluster1
NTNX_IP=192.168.1.1
NTNX_USERNAME=admin
NTNX_PASSWORD=nutanix/4u
EOF
$ chmod 600 cluster1
```

Now you can run a new container and pass the variables as a file.
```bash
$ docker run -it --rm --env-file cluster1 ncli:latest
```

**Disclaimer:** Containerised nCLI is not officially supported by Nutanix. Please use at your own risk.