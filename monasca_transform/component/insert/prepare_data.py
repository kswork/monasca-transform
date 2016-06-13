# Copyright 2016 Hewlett Packard Enterprise Development Company LP
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

from monasca_transform.component.insert import InsertComponent


class PrepareData(InsertComponent):
    """prepare for insert component validates instance usage
    data before calling Insert component
    """
    @staticmethod
    def insert(transform_context, instance_usage_df):
        """write instance usage data to kafka"""

        #
        # FIXME: add instance usage data validation
        #

        return instance_usage_df