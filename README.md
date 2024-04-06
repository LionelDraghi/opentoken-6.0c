OpenToken Package Readme

--------------------------------------------------------------------------

**Note that OpenToken is no more maintained**

The successor of OpenToken is available on Stephen Leake home : [WisiToken](https://stephe-leake.org/ada/wisitoken.html)

This release was made available for the creation of a specific crates, when porting [archicheck](https://github.com/LionelDraghi/ArchiCheck) on ALire.

The modifications respect to the last official version (the 6.0b) are :
- [Fixed] Analyzer.Reset missing in Ada_Lexer Set_Input_Feeder procedure
- [Added] Annotation support added in the Java_Lexer (MetaData starting with @)
- [Changed] Buffer_Size of the Tokenizer in Java_Lexer increased to 8192
- [Changed] cosmetic modifications in comments to comply with gnat standards
- [Changed] some useless "with" removed

NB : Due to Alire using semantic versioning, 6.0c is named 6.0.3 in Alire

Lionel Draghi, april 2024

--------------------------------------------------------------------------

See Docs/opentoken.html for more info, including installation instructions.

OpenToken is useable in pure source form. There is a GNAT project file
in Build/windows_release/opentoken.gpr.

OpenToken is distributed under GPL version 3, with the GNAT
modification that allows use in non-GPL projects.

See the Examples and Test directories for examples of OpenToken applications.

OpenToken is currently maintained by Stephen Leake; mailto:stephen_leake@stephe-leake.org.

Submit bugs via the Debian Bug system http://bugs.debian.org/Bugs/, against the opentoken source package.

Discussion about OpenToken is on the newsgroup comp.lang.ada.

The current status is available here: https://packages.qa.debian.org/o/opentoken.html
