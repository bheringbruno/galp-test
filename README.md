## Galp Test
### This code creates an AWS infraestructure as specified

### Required Input Variables

```
NAME = name to use for all resources
SUBNET_COUNT = the number of subnet to use
REGION = default us-east-1
```

### Build Image:
note: make plan already build the image
```
make build NAME=IMAGE_NAME REGION=REGION
make build NAME=galp-image REGION=us-east-1
```

### Create it:
```
 make plan NAME=galp-image REGION=us-east-1 SUBNET_COUNT=4 && make apply
 ```

### Destroy it:
```
make destroy
```


