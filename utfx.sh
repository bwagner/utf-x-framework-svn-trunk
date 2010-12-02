#
# TODO: how to repackage saxon9he with RSA, etc. in the single jar
# TODO: create a jar target for the Factory! Currently putting "bin"
#       into the classpath. This is not deployable!
# TODO: TransformerFactoryImpl not found when using the -jar call. See:
# http://stackoverflow.com/questions/2018257/how-to-combine-library-with-my-jar
# Quoting above:
#   Executable JARs are launched with the "-jar" argument to the java
#   executable, and both the java "-cp" flag and the CLASSPATH environment
#   variable are ignored.

SAXON=lib/saxon9he.jar
THIRD_PARTY_JARS=
TRANSFORM_FACTORY= #-Djavax.xml.transform.TransformerFactory=...
UTFX=.:build/jar/utfxFat.jar
CLASSES=bin
UTFX_TEST=-Dutfx.test.file=test_xsl/dtbook2sbsform_test.xml
UTFX_TEST=-Dutfx.test.dir=test_xsl

java \
	$TRANSFORM_FACTORY \
	$UTFX_TEST \
	-cp $SAXON:$THIRD_PARTY_JARS:$CLASSES:$UTFX \
	 utfx.runner.TestRunner utfx.framework.XSLTRegressionTest
