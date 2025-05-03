/// Interface for managing lending positions in the Alpha Lending protocol
module alpha_lending::position {
    use sui::object::{ID, UID};
    use sui::vec_map::{VecMap};
    use sui::balance::{Balance};
    use sui::coin::{Coin};
    use sui::clock::{Clock};
    use std::type_name::{TypeName};
    use alpha_lending::market::{XToken, Market};
    use alpha_lending::rewards::{UserRewardDistributor};
    use alphafi_stdlib::math::Number;

    // Public structs
    public struct PositionCap has store, key {
        id: UID,
        position_id: ID,
        client_address: address,
    }

    public struct Position has store, key {  
        id: UID,
        partner_id: Option<ID>,
        lp_collaterals: Option<LpPositionCollateral>,
        collaterals: VecMap<u64,u64>,
        loans: vector<Borrow>,
        total_collateral_usd: Number,
        safe_collateral_usd: Number,
        liquidation_value: Number,
        additional_permissible_borrow_usd: Number,
        total_loan_usd: Number,
        spot_total_loan_usd: Number,
        weighted_total_loan_usd: Number,
        weighted_spot_total_loan_usd: Number,
        is_position_healthy: bool,
        is_position_liquidatable: bool,
        reward_distributors: vector<UserRewardDistributor>,
        is_isolated_borrowed: bool,
        last_refreshed: u64
    }

    public struct LpPositionCollateralConfig has drop, store {
        safe_collateral_ratio: u8,
        liquidation_threshold: u8,
        liquidation_bonus: u64,
        liquidation_fee: u64,
        close_factor_percentage: u8
    }

    public struct LpPositionCollateral has store {
        pool_id: ID,
        lp_position_id: ID,
        usd_value: Number,
        safe_usd_value: Number,
        liquidation_value: Number,
        liquidity: u128,
        config: LpPositionCollateralConfig,
        last_updated: u64,
        lp_type: u8
    }

    public struct TokenCollateral<phantom C> has store {
        market_id: u64,
        x_token: Balance<XToken<C>>,
        reward_distributor_index: u64
    }

    public struct Borrow has store {
        coin_type: TypeName,
        market_id: u64,
        amount: u64,
        borrow_time: u64,
        borrow_compounded_interest: Number,
        reward_distributor_index: u64
    }

    // Events
    public struct PositionCreateEvent has copy, drop {
        position_id: ID,
        partner_id: Option<ID>
    }

    public struct PositionUpdateEvent has copy, drop {
        position_id: ID,
        partner_id: Option<ID>,
        total_collateral_usd: Number,
        safe_collateral_usd: Number,
        liquidation_value: Number,
        additional_permissible_borrow_usd: Number,
        total_loan_usd: Number,
        spot_total_loan_usd: Number,
        weighted_total_loan_usd: Number,
        weighted_spot_total_loan_usd: Number,
        is_position_healthy: bool,
        is_position_liquidatable: bool
    }

    public fun is_healthy (
        position: &Position,
    ): bool {
        abort 0
    }

    public fun is_liquidatable(
        position: &Position,
        clock: &Clock
    ) : bool {
        abort 0
    }
    
    
} 