#
# TODO: how to repackage saxon9he with RSA, etc. in the single jar
# TODO: TransformerFactoryImpl not found when using the -jar call. See:
# http://stackoverflow.com/questions/2018257/how-to-combine-library-with-my-jar
# Quoting above:
#   Executable JARs are launched with the "-jar" argument to the java
#   executable, and both the java "-cp" flag and the CLASSPATH environment
#   variable are ignored.

SAXON=lib/saxon9he.jar
THIRD_PARTY_JARS=
TRANSFORM_FACTORY= #-Djavax.xml.transform.TransformerFactory=...
UTFX_FAT=build/jar/utfxFat.jar
UTFX=.:$UTFX_FAT
CLASSES=bin
PRGNAME=$0

if [ ! -e $UTFX_FAT ] ; then
	cat <<END

$UTFX_FAT not yet built. Please run:

 ant fatjar
	
before trying again!
	
END
	exit 1
fi

if [ $# = 0 ] ; then
	cat <<END

please pass utfx test, either:
$PRGNAME -Dutfx.test.file=samples/history/test/history_xhtml_test.xml
or:
$PRGNAME -Dutfx.test.dir=samples/history

END
	exit 2
fi

java \
	$TRANSFORM_FACTORY \
	"$@" \
	-cp $SAXON:$THIRD_PARTY_JARS:$CLASSES:$UTFX \
	 utfx.runner.TestRunner utfx.framework.XSLTRegressionTest
