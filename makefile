# OS_VERSION 환경변수 등록 필수
SWIFTLINT = $(shell command -v swiftlint)
XCPRETTY = $(shell command -v xcpretty)

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
ifndef XCPRETTY
	$(error xcpretty를 설치하세요)
endif
	xcodebuild \
	-workspace strolling-of-time-ios.xcworkspace \
	-configuration Debug \
	-scheme strolling-of-time-ios \
	-destination 'platform=iOS Simulator,OS=${OS_VERSION},name=iPhone 7' \
	-enableCodeCoverage YES \
	build test \
	CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=YES | xcpretty
.PHONY: build
if [[ "$TRAVIS_BRANCH" == "master" ]]; then \
xcodebuild test 
-workspace OptimizelySwiftSDK.xcworkspace \
-scheme $SCHEME \
-configuration Release CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO \
-sdk $TEST_SDK \
-destination "platform=$PLATFORM,OS=$OS,name=$NAME" ONLY_ACTIVE_ARCH=YES > buildoutput; cat buildoutput | xcpretty; \
fi

test:
ifndef OS_VERSION
	$(error OS_VERSION이 환경변수에 등록되어있지 않습니다)
endif
ifndef XCPRETTY
	$(error xcpretty를 설치하세요)
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
	ONLY_ACTIVE_ARCH=NO | xcpretty
.PHONY: test

coverage:
	slather coverage --html --scheme strolling-of-time-ios strolling-of-time-ios.xcodeproj
.PHONY: coverage