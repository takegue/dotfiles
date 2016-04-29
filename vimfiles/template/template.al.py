:let b:input_file = 'case1'
:cd %:p:h
#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Documents
    Updated:2016-04-25

"""
from collections import Counter, defaultdict
from itertools import *
from itertools import izip as zip

range = xrange

from functools import partial
from functools import update_wrapper
from math import *

import heapq

class Memo:

    def __init__(self,func):
        self._cache = {}
        self.func = func

    def __call__(*args, **kw):

        if args in self._cache:
            return self._cache[args]
        else:
            self._cache[args] = val
            val = self.func(*args, **kw)
            return val


<+CURSOR+>
