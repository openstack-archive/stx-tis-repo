#!/bin/bash

# devstack/plugin.sh
# Triggers specific functions to install and configure stx-integ

echo_summary "$STX_TIS_NAME devstack plugin.sh called: $1/$2"


# check for service enabled
if is_service_enabled $STX_TIS_NAME; then
    if [[ "$1" == "stack" && "$2" == "install" ]]; then
        # Perform installation of source
        echo_summary "Install $STX_TIS_NAME"

        if is_service_enabled $STX_CONFIG_NAME; then
            install_config
        fi

        if is_service_enabled $STX_FAULT_NAME; then
            install_fault
        fi

        if is_service_enabled $STX_METAL_NAME; then
            install_maintenance
        fi

    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        # Configure after the other layer 1 and 2 services have been configured
        echo_summary "Configure $STX_TIS_NAME"

        if is_service_enabled $STX_CONFIG_NAME; then
            configure_config
        fi

        if is_service_enabled $STX_FAULT_NAME; then
            configure_fault
            create_fault_user_group
            create_fault_accounts
        fi

        if is_service_enabled $STX_METAL_NAME; then
            configure_maintenance
        fi

    elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
        # Initialize and start the service
        echo_summary "Initialize and start $STX_TIS_NAME"

        if is_service_enabled $STX_CONFIG_NAME; then
            init_config
            start_config
        fi

        if is_service_enabled $STX_FAULT_NAME; then
            init_fault
            start_fault
        fi

        if is_service_enabled $STX_METAL_NAME; then
            start_maintenance
        fi
    elif [[ "$1" == "stack" && "$2" == "test-config" ]]; then
        # do sanity test
        echo_summary "test-config $STX_TIS_NAME"

        if is_service_enabled $STX_CONFIG_NAME; then
            check_sysinv_services
        fi
    fi

    if [[ "$1" == "unstack" ]]; then
        # Shut down services
        echo_summary "Stop $STX_TIS_NAME"

        if is_service_enabled $STX_CONFIG_NAME; then
            stop_config
        fi

        if is_service_enabled $STX_FAULT_NAME; then
            stop_fault
        fi

        if is_service_enabled $STX_METAL_NAME; then
            stop_maintenance
        fi
    fi

    if [[ "$1" == "clean" ]]; then
        echo_summary "Clean $STX_TIS_NAME"

        if is_service_enabled $STX_CONFIG_NAME; then
            cleanup_config
        fi

        if is_service_enabled $STX_FAULT_NAME; then
            cleanup_fault
        fi

        if is_service_enabled $STX_METAL_NAME; then
            clean_maintenance
        fi
    fi
fi
