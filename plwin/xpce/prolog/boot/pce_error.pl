/*  $Id: pce_error.pl,v 1.5 2002/02/01 15:04:48 jan Exp $

    Part of XPCE --- The SWI-Prolog GUI toolkit

    Author:        Jan Wielemaker and Anjo Anjewierden
    E-mail:        jan@swi.psy.uva.nl
    WWW:           http://www.swi.psy.uva.nl/projects/xpce/
    Copyright (C): 1985-2002, University of Amsterdam

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

    As a special exception, if you link this library with other files,
    compiled with a Free Software compiler, to produce an executable, this
    library does not by itself cause the resulting executable to be covered
    by the GNU General Public License. This exception does not however
    invalidate any other reasons why the executable file might be covered by
    the GNU General Public License.
*/

:- module(pce_error,
	  [ pce_catch_error/2
	  ]).

:- meta_predicate
	pce_catch_error(+, :).

:- use_module(pce_boot(pce_principal)).


%	pce_catch_error(?Errors, Goal)
%
%	Run goal, fail silently on indicated errors.  If the first argument
%	is a variable, any error will be catched.

pce_catch_error(Error, Goal) :-
	var(Error), !,
	send(@pce, catch_error, @default),
	(   Goal
	->  send(@pce, catch_pop)
	;   send(@pce, catch_pop),
	    fail
	).
pce_catch_error(Errors, Goal) :-
	send(@pce, catch_error, Errors),
	(   Goal
	->  send(@pce, catch_pop)
	;   send(@pce, catch_pop),
	    fail
	).
