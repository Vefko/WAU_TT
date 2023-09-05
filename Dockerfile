##############################################################################
# Copyright (C) 2023 vefko and the wau tt contributors
# Take a look at the contributors.txt
#  
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#         http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################

# Start from a base image with bash and other utilities
FROM debian:latest

# Set workdir in /usr/src/app
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    diffutils \
    grep

# Copy your bash script into the container
COPY autoupdate.sh .

# Give execution permissions to the script
RUN chmod +x autoupdate.sh

# Run the command on container startup
CMD ["./autoupdate.sh"]