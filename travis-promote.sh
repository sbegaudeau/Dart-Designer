echo "Build $TRAVIS_JOB_NUMBER"
echo "Commit $TRAVIS_COMMIT [$TRAVIS_BRANCH]"
echo "Java version: $TRAVIS_JDK_VERSION"
CURRENT_TAG=$(git name-rev --name-only --tags HEAD)
if [[ $CURRENT_TAG == 'undefined' ]];
then
    echo "Promoting an untagged build on dartdesigner.github.io/p2/nightly"
	cd $TRAVIS_BUILD_DIR/Dart-Designer/repositories/org.obeonetwork.dsl.dart.repository/target
	git clone https://$GITHUB_TOKEN@github.com/dartdesigner/p2.git#gh-pages
	if [-d p2/nightly]
	then
	    rm -r p2/nightly
	fi
	cp -r repository p2/
	mv p2/repository p2/nightly
	cd p2
	git add .
	git commit -m "$TRAVIS_COMMIT-MESSAGE"
	git push origin gh-pages
else
    if [[ $TRAVIS_PULL_REQUEST == 'false' ]];
	then
	    LAST_TAG=$(git describe --abbrev=0 --tags)
        echo "Promoting the release $LAST_TAG"
	fi
fi