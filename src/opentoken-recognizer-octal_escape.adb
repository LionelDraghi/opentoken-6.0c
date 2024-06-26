-- ----------------------------------------------------------------------------
--
--  Copyright (C) 1999 Christoph Karl Walter Grein
--
--  This file is part of the OpenToken package.
--
--  The OpenToken package is free software; you can redistribute it and/or
--  modify it under the terms of the  GNU General Public License as published
--  by the Free Software Foundation; either version 3, or (at your option)
--  any later version. The OpenToken package is distributed in the hope that
--  it will be useful, but WITHOUT ANY WARRANTY; without even the implied
--  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for  more details.  You should have received
--  a copy of the GNU General Public License  distributed with the OpenToken
--  package;  see file GPL.txt.  If not, write to  the Free Software Foundation,
--  59 Temple Place - Suite 330,  Boston, MA 02111-1307, USA.
--
--  As a special exception, if other files instantiate generics from
--  this unit, or you link this unit with other files to produce an
--  executable, this unit does not by itself cause the resulting
--  executable to be covered by the GNU General Public License. This
--  exception does not however invalidate any other reasons why the
--  executable file might be covered by the GNU Public License.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
--  This package implements a token recognizer for an escape sequence character.
-- ----------------------------------------------------------------------------
package body OpenToken.Recognizer.Octal_Escape is

   -- -------------------------------------------------------------------------
   --  This procedure will be called when analysis on a new candidate string
   --  is started. The Token needs to clear its state (if any).
   -- -------------------------------------------------------------------------
   overriding procedure Clear (The_Token : in out Instance) is
   begin

      Extended_Digits.Clear (The_Token.Octal_Recognizer);
      The_Token.State := Opening_Tick;

   end Clear;

   -- -------------------------------------------------------------------------
   --  This procedure will be called to perform further analysis on a token
   --  based on the given next character.
   -- -------------------------------------------------------------------------
   overriding procedure Analyze
     (The_Token : in out Instance;
      Next_Char : in     Character;
      Verdict   :    out Analysis_Verdict)
   is begin

      case The_Token.State is

      when Opening_Tick =>

         if Next_Char = ''' then
            Verdict         := So_Far_So_Good;
            The_Token.State := Escape;
         else
            Verdict         := Failed;
            The_Token.State := Done;
         end if;

      when Escape =>

         if Next_Char = '\' then
            Verdict         := So_Far_So_Good;
            The_Token.State := Octal_First;
         else
            Verdict         := Failed;
            The_Token.State := Done;
         end if;

      when Octal_First =>

         Extended_Digits.Analyze (The_Token.Octal_Recognizer, Next_Char, Verdict);

         if Verdict = Matches then
            Verdict         := So_Far_So_Good;
            The_Token.State := Octal;
         else
            Verdict         := Failed;
            The_Token.State := Done;
         end if;

      when Octal =>

         Extended_Digits.Analyze (The_Token.Octal_Recognizer, Next_Char, Verdict);

         if Verdict = Matches then
            Verdict := So_Far_So_Good;
         elsif Next_Char = ''' then
            Verdict         := Matches;
            The_Token.State := Done;
         else
            Verdict         := Failed;
            The_Token.State := Done;
         end if;

      when Done =>

         Verdict := Failed;

      end case;

   end Analyze;

   -- -------------------------------------------------------------------------
   --  This procedure will be called to create a character set token
   -- -------------------------------------------------------------------------
   function Get return Instance is

   begin

      return (Report           => True,
              Octal_Recognizer => Extended_Digits.Get (For_Base          => 8,
                                                       Allow_Underscores => False),
              State            => Opening_Tick);

   end Get;

end OpenToken.Recognizer.Octal_Escape;
