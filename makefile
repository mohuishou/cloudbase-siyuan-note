img := ccr.ccs.tencentyun.com/tcb-306755605-hcwi/mohuishou-2g6ja2t62ad49804_siyuan
now := $(shell date +%Y%m%d%H%M%S)

build:
	docker build -t $(img) .
	docker tag $(img):latest $(img):$(now)

push: build
	docker push $(img):$(now)

run: build
	docker run --rm -p 8886:6806 \
		-e RCLONE=sync \
		-v $$(pwd)/siyuan/data:/siyuan/data \
		-v $$(pwd)/siyuan/conf:/siyuan/conf \
		-v $$(pwd)/siyuan/rclone:/siyuan/rclone \
		-v $$(pwd)/siyuan/log:/siyuan/log \
	 	$(img)