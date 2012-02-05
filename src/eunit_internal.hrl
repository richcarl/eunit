%% Licensed under the Apache License, Version 2.0 (the "License"); you may
%% not use this file except in compliance with the License. You may obtain
%% a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% Alternatively, you may use this file under the terms of the GNU Lesser
%% General Public License (the "LGPL") as published by the Free Software
%% Foundation; either version 2.1, or (at your option) any later version.
%% If you wish to allow use of your version of this file only under the
%% terms of the LGPL, you should delete the provisions above and replace
%% them with the notice and other provisions required by the LGPL; see
%% <http://www.gnu.org/licenses/>. If you do not delete the provisions
%% above, a recipient may use your version of this file under the terms of
%% either the Apache License or the LGPL.
%%
%% Copyright (C) 2006 Richard Carlsson <carlsson.richard@gmail.com>

-define(SERVER, eunit_server).
-define(DEFAULT_TEST_SUFFIX, "_test").
-define(DEFAULT_GENERATOR_SUFFIX, "_test_").
-define(DEFAULT_EXPORT_SUFFIX, "_exported_").
-define(DEFAULT_TESTMODULE_SUFFIX, "_tests").
-define(DEFAULT_GROUP_TIMEOUT, infinity).
-define(DEFAULT_TEST_TIMEOUT, 5000).
-define(DEFAULT_SETUP_PROCESS, spawn).
-define(DEFAULT_MODULE_WRAPPER_NAME, eunit_wrapper_).

-ifdef(DEBUG).
-define(debugmsg(S),io:fwrite("\n* ~s: ~s\n", [?MODULE,S])).
-define(debugmsg1(S,As),io:fwrite("\n* ~s: " ++ S ++ "\n", [?MODULE] ++ As)).
-else.
-define(debugmsg(S),ok).
-define(debugmsg1(S,As),ok).
-endif.


%% ---------------------------------------------------------------------
%% Internal test data representation

-record(test, {f = undefined,
	       desc = undefined,
	       timeout = undefined,
	       location = undefined,
	       line = 0
	      }).

-record(group, {desc = undefined,
		order = undefined,	% run in order or in parallel
		timeout = undefined,
		context = undefined,	% setup-context record
		spawn = undefined,	% run group in new process
		tests = undefined}).

-record(context, {setup = undefined,
		  cleanup = undefined,
		  process = local}).    % spawn new process for body

-atoms([verbose, report, no_tty, event_log, enqueue, eunit_test_suffix,
        eunit_generator_suffix, eunit_export_suffix]). % options
-atoms([no, prefix, exact]). % trie matching
-atoms(['begin', 'end', progress, group]). % serialization
-atoms([start, done, result, group, test, id, size, pass, fail, skip,
        cancel, skipped, abort, aborted, failed, blame, startup,
        desc, order, time, source, line, output, reason]). % listeners
-atoms([bad_test, context_error, no_such_function, module_not_found,
        cleanup_failed, instantiation_failed, setup_failed,
        generator_failed, application_not_found, file_read_error,
        server_down, no_server]). % errors
-atoms([?SERVER, ?DEFAULT_MODULE_WRAPPER_NAME, eunit_internal
       ]). % internals
