# !/usr/bin/env Python
# -*- coding:utf-8 -*-

import pytest

class test_description:
    def pytest_funcarg__<+arg name+>(request):
        return request
        
if __name__ == '__main__':
    pytest.main()
