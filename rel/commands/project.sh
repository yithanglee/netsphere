#!/bin/sh
            cd /commerce_front
            echo  | sudo -S tar xfz commerce_front.tar.gz
            sudo mv /commerce_front/commerce_front.tar.gz /commerce_front/releases/0.1.0/
            sudo /commerce_front/bin/commerce_front stop
            sudo /commerce_front/bin/commerce_front migrate
            sudo /commerce_front/bin/commerce_front start
            