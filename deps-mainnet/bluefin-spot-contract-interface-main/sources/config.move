// Copyright (c) Seed Labs

#[allow(unused_field, unused_variable,unused_type_parameter, unused_mut_parameter)]
/// Config Module
/// The config module stores the protocol configs and exposes methods for admin to update the config
/// and getter methods to retrive config values
module bluefin_spot::config {
    use sui::object::{UID};
    use integer_mate::i32::{Self,I32};
    use sui::tx_context::{TxContext};
    use sui::object::{Self};

    //===========================================================//
    //                         Constants                         //
    //===========================================================//

    /// The protocol's config
    struct GlobalConfig has key, store {
        id: UID,
        /// min tick supported
        min_tick: I32,
        /// max tick supported
        max_tick: I32,
        /// the current pkg version supported
        version: u64,
        /// Accounts that are whitelisted to update rewards on any pool
        reward_managers: vector<address>
    }


    //===========================================================//
    //                      Public Methods                       //
    //===========================================================//

    /// Returns the min/max tick allowed
    public fun get_tick_range(config: &GlobalConfig): (I32, I32){
        abort 0
    }

    /// Assets if the config vesion matches the protocol version
    public fun verify_version(config: &GlobalConfig) {
        abort 0
    }

    /// Checks if the given address is the whitelisted rewards manager
    public fun verify_reward_manager(config: &GlobalConfig, manager: address) : bool {
       abort 0
    }

    #[test_only]
    public fun create_config_for_testing(ctx: &mut TxContext) : GlobalConfig {
        let config = GlobalConfig {
            id: object::new(ctx),
            min_tick: i32::zero(),
            max_tick: i32::zero(),
            version: 0,
            reward_managers: vector[]
        };
        config
    }

}