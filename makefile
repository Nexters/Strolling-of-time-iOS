# OS_VERSION 환경변수 등록 필수
SWIFTLINT = $(shell command -v swiftlint)

lint:
ifndef SWIFTLINT
	./install_swiftlint.sh
endif
	swiftlint
.PHONY: lint

build:
ifndef OS_VERSION
	$(error OS_VERSION이 환경변수에 등록되어있지 않습니다)
endif
	xcodebuild \
	-workspace strolling-of-time-ios.xcworkspace \
	-configuration Debug \
	-scheme strolling-of-time-ios \
	-derivedDataPath BuildFolder/ \
	-destination 'platform=iOS Simulator,OS=${OS_VERSION},name=iPhone 7' \
	-enableCodeCoverage YES \
	build test \
	CODE_SIGN_IDENTITY="" \
	CODE_SIGNING_REQUIRED=NO \
	ONLY_ACTIVE_ARCH=NO \
	-quiet
.PHONY: build

test:
ifndef OS_VERSION
	$(error OS_VERSION이 환경변수에 등록되어있지 않습니다)
endif
	xcodebuild \
	-workspace strolling-of-time-ios.xcworkspace \
	-configuration Debug \
	-scheme strolling-of-time-ios \
	-destination 'platform=iOS Simulator,OS=${OS_VERSION},name=iPhone 7' \
	-enableCodeCoverage YES \
	test \
	CODE_SIGN_IDENTITY="" \
	CODE_SIGNING_REQUIRED=NO \
	ONLY_ACTIVE_ARCH=NO \
	-quiet
.PHONY: test

coverage:
	slather coverage --html --scheme strolling-of-time-ios strolling-of-time-ios.xcodeproj
.PHONY: coverage