#!/usr/bin/env bash

# For more information consult https://packaging.python.org/tutorials/packaging-projects

# Make sure that only the newest distribution will be uploaded
rm -rf dist
# Make sure you have the latest versions of setuptools and wheel installed:
python3 -m pip install --user --upgrade setuptools wheel || (echo "Failed to install dependencies" && exit 1)
# Now run this command from the same directory where setup.py is located:
python3 setup.py sdist bdist_wheel  || (echo "Failed to build package" && exit 2)

# Now that you are registered, you can use twine to upload the distribution packages. You’ll need to install Twine:
python3 -m pip install --user --upgrade twine || (echo "Failed to install twine" && exit 3)

# Once installed, run Twine to upload all of the archives under dist:
case "$1" in
    "deploy")
    # This will upload to the pypi site.
    python3 -m twine upload dist/* || (echo "Failed to upload to pypi" && exit 4) ;;
    "test")
    # This will upload to the test pypi:
    python3 -m twine upload --repository testpypi dist/* || (echo "Failed to upload to test pypi" && exit 4) ;;
    *)
        echo "Error!!! You must provide deploy or test..." && exit 4
esac
