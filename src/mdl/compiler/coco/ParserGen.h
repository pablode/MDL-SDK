/*-------------------------------------------------------------------------
ParserGen -- Generation of the Recursive Descent Parser
Compiler Generator Coco/R,
Copyright (c) 1990, 2004 Hanspeter Moessenboeck, University of Linz
ported to C++ by Csaba Balazs, University of Szeged
extended by M. Loeberbauer & A. Woess, Univ. of Linz
with improvements by Pat Terry, Rhodes University

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation; either version 2, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

As an exception, it is allowed to write an extension of Coco/R that is
used as a plugin in non-free software.

If not otherwise stated, any source code generated by Coco/R (other than
Coco/R itself) does not fall under the GNU General Public License.
-------------------------------------------------------------------------*/

#if !defined(COCO_PARSERGEN_H__)
#define COCO_PARSERGEN_H__

#include "Position.h"
#include "Tab.h"
#include "Symbol.h"
#include "Scanner.h"
#include "DFA.h"

namespace Coco {

class Errors;
class Parser;
class BitArray;

class ParserGen
{
public:
	int maxTerm;		// sets of size < maxTerm are enumerated
	char CR;
	char LF;

	enum ErrorType {
		tErr    = 0,	// Token expected error
		altErr  = 1,	// no matching alternative
		syncErr = 2		// unexpected Token, rewind to sync point
	};

	Position *usingPos; // "using" definitions from the attributed grammar

	int errorNr;      // highest parser error number
	Symbol *curSy;    // symbol whose production is currently generated
	FILE* fram;       // parser frame file
	FILE* gen; // generated parser source file
	char* err; // generated parser error messages
	ArrayList symSet;

	Tab *tab;         // other Coco objects
	FILE* trace;
	Errors *errors;
	Buffer *buffer;

	void Indent(int n);
	bool UseSwitch(Node *p);
	void CopyFramePart(const char *stop);
	void CopySourcePart(Position *pos, int indent);
	int GenNamespaceOpen(const char* nsName);
	void GenNamespaceClose(int nrOfNs);
	void GenErrorMsg(ErrorType errTyp, Symbol *sym);
	int  NewCondSet(const BitArray *s);
	void GenCond(const BitArray *s, Node *p);
	void PutCaseLabels(const BitArray *s);
	void GenCode(Node *p, int indent, BitArray &isChecked);
	void GenTokensHeader();
	void GenPragmas();
	void GenCodePragmas();
	void GenProductions();
	void GenProductionsHeader();
	void InitSets();
	void OpenGen(const char *genName, bool backUp);
	void WriteParser();
	void WriteStatistics();
	void WriteSymbolOrCode(FILE *gen, const Symbol *sym);
	ParserGen (Parser *parser);

};

}; // namespace

#endif // !defined(COCO_PARSERGEN_H__)
