#! /bin/bash

finish() {
    echo ">> Exiting now..."
    cd $(dirname $0)
    exit
}

SITE_DIR=$(dirname "$0")/public
COMMIT_MSG=$(git log -1 --format=%s | cat)

echo ">> Building static site."
hugo

echo ">> Commiting changes to site."
cd $SITE_DIR
git add --all
echo ">> Changes:"
git status -s

echo ">> Commit with message \"$COMMIT_MSG\"?"
select choice in "Yes" "No"; do
    case $choice in
        Yes) git commit -m "$COMMIT_MSG"; break;;
        No) finish;;
    esac
done

echo ">> Deploy changes to jwoodger.github.io?"
select choice in "Yes" "No"; do
    case $choice in
        Yes) git push origin main; break;;
        No) finish;;
    esac
done

finish
