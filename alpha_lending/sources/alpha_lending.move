/// Interface for the Alpha Lending protocol that handles lending, borrowing, and liquidation operations
module alpha_lending::alpha_lending {
    use sui::coin::{Coin};
    use sui::clock::{Clock};
    use sui::balance::Balance;
    use alpha_lending::market::{Market, MarketCap, XToken, LiquidityPromise};
    use alpha_lending::position::{Position, PositionCap};
    use alpha_lending::oracle::{Oracle, PriceIdentifier};
    use alpha_lending::partner::{Partner, PartnerCap};
    use alpha_lending::rewards::{ClaimableReward};
    use bluefin_spot::position::Position as BFPosition;
    use bluefin_spot::pool::Pool as BFPool;
    use bluefin_spot::config::GlobalConfig as BFConfig;
    use sui::object::{ID, UID};
    use std::type_name::{TypeName};
    use sui::table::{Table};
    use sui::sui::SUI;

    // Public structs
    public struct ALPHA_LENDING has drop {}

    public struct LendingProtocol has key, store {
        id: UID,
        lending_protocol_cap_id: ID,
        positions: Table<ID, Position>,
        markets: Table<u64, Market>,
        oracle: Oracle,
        protocol_fee_address: address,
        version: u64,
        config: LendingProtocolConfig,
        admin_cap_id: ID
    }

    public struct LendingProtocolConfig has store {
        max_safe_collateral_ratio: u8,
        max_liquidation_threshold: u8,
        max_liquidation_bonus_bps: u64,
        max_liquidation_fee_bps: u64,
        lp_position_safe_collateral_ratio: u8,
        lp_position_liquidation_threshold: u8,
    }

    public struct LendingProtocolCap has key, store {
        id: UID,
    }



    public struct LpPositionBorrowHotPotato has drop {
        position_id: ID,
        lp_position_id: ID
    }

    // Public functions
    public fun create_position(
        protocol: &mut LendingProtocol,
        ctx: &mut TxContext
    ): PositionCap {
        abort 0
    }

    public fun add_collateral<C>(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap,
        market_id: u64,
        coin: Coin<C>,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun remove_collateral<C>(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap,
        market_id: u64,
        amount: u64,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun borrow<C>(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap,
        market_id: u64,
        amount: u64,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun repay<C>(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap,
        market_id: u64,
        coin: Coin<C>,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun liquidate<B,D>(
        protocol: &mut LendingProtocol,
        liquidate_position_id: ID,
        borrow_market_id: u64,
        withdraw_market_id: u64,
        repay_coin: Coin<B>,
        clock: &Clock,
        ctx: &mut TxContext
    ): (Coin<D>, Coin<B>) {
        abort 0
    }

    public fun liquidate_lp_position<A,B,Borrow>(
        protocol: &mut LendingProtocol,
        liquidate_position_id: ID,
        borrow_market_id: u64,
        bf_pool: &mut BFPool<A,B>,
        repay_coin: Coin<Borrow>,
        bf_config: &BFConfig,
        clock: &Clock,
        ctx: &mut TxContext
    ): (Coin<A>, Coin<B>, Coin<Borrow>) {
        abort 0
    }

    public fun add_reward<C>(
        protocol: &mut LendingProtocol,
        market_id: u64,
        market_cap: &MarketCap,
        is_deposit: bool,
        balance: Balance<C>,
        start_time: u64,
        end_time: u64,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        abort 0
    }

    public fun collect_reward<C>(
        protocol: &mut LendingProtocol,
        market_id: u64,
        position_cap: &PositionCap,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun collect_reward_and_deposit<C>(
        protocol: &mut LendingProtocol,
        market_id: u64,
        position_cap: &PositionCap,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun withdraw_market_fee<C>(
        protocol: &mut LendingProtocol,
        market_cap: &MarketCap,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun loan_bailout<C>(
        protocol: &mut LendingProtocol,
        market_id: u64,
        position_id: ID,
        coin: Coin<C>,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun add_market<C>(
        protocol: &mut LendingProtocol,
        liquidity: Coin<C>,
        safe_collateral_ratio: u8,
        liquidation_threshold: u8,
        deposit_limit: u64,
        borrow_limit: u64,
        borrow_fee_bps: u64,
        deposit_fee_bps: u64,
        withdraw_fee_bps: u64,
        price_identifier: PriceIdentifier,
        collateral_types: vector<TypeName>,
        interest_rate_kinks: vector<u8>,
        interest_rates: vector<u16>,
        liquidation_bonus_bps: u64,
        liquidation_fee_bps: u64,
        spread_fee_bps: u64,
        cascade_market_id: u64,
        protocol_fee_share_bps: u64,
        decimal_digit: u8,
        clock: &Clock,
        ctx: &mut TxContext
    ): MarketCap {
        abort 0
    }

    public fun update_market_deposit_limit(
        protocol: &mut LendingProtocol,
        market_id: u64,
        market_cap: &MarketCap,
        deposit_limit: u64,
        clock: &Clock
    ) {
        abort 0
    }

    public fun update_market_borrow_limit(
        protocol: &mut LendingProtocol,
        market_id: u64,
        market_cap: &MarketCap,
        borrow_limit: u64,
        clock: &Clock
    ) {
        abort 0
    }

    public fun update_flow_limiter(
        protocol: &mut LendingProtocol,
        market_cap: &MarketCap,
        is_deposit: bool,
        max_rate: u64,
        window_duration: u64,
        clock: &Clock
    ) {
        abort 0
    }

    public fun get_version(protocol: &LendingProtocol): u64 {
        abort 0
    }

    public fun update_market_fee_config(
        protocol: &mut LendingProtocol,
        market_cap: &MarketCap,
        borrow_fee_bps: u64,
        deposit_fee_bps: u64,
        withdraw_fee_bps: u64,
        spread_fee_bps: u64,
        borrow_weight_bps: u64,
        clock: &Clock
    ) {
        abort 0
    }

    public fun update_market_collateral_ratios(
        protocol: &mut LendingProtocol,
        market_id: u64,
        market_cap: &MarketCap,
        safe_collateral_ratio: u8,
        liquidation_threshold: u8,
        clock: &Clock
    ) {
        abort 0
    }

    public fun update_market_interest_rate_config(
        protocol: &mut LendingProtocol,
        market_id: u64,
        market_cap: &MarketCap,
        interest_rate_kinks: vector<u8>,
        interest_rates: vector<u16>,
        clock: &Clock
    ) {
        abort 0
    }

    public fun update_market_liquidation_config(
        protocol: &mut LendingProtocol,
        market_id: u64,
        market_cap: &MarketCap,
        liquidation_bonus_bps: u64,
        liquidation_fee_bps: u64,
        close_factor_percentage: u8,
        clock: &Clock
    ) {
        abort 0
    }

    public fun get_claimable_rewards(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap,
        clock: &Clock
    ): vector<ClaimableReward> {
        abort 0
    }

    public fun add_bluefin_lp_collateral<A,B>(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap,
        lp_position: BFPosition,
        pool: &BFPool<A,B>,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        abort 0
    }

    public fun borrow_bluefin_lp_collateral(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap,
        _ctx: &mut TxContext
    ): (BFPosition, LpPositionBorrowHotPotato) {
        abort 0
    }

    public fun return_bluefin_lp_collateral<A,B>(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap,
        pool: &BFPool<A,B>,
        bf_position: BFPosition,
        hot_potato: LpPositionBorrowHotPotato,
        clock: &Clock,
        _ctx: &mut TxContext
    ) {
        abort 0
    }

    public fun update_bluefin_lp_collateral_usd_value<A,B>(
        protocol: &mut LendingProtocol,
        position_id: ID,
        pool: &BFPool<A,B>,
        clock: &Clock
    ) {
        abort 0
    }

    public fun remove_bluefin_lp_collateral(
        protocol: &mut LendingProtocol,
        position_cap: &PositionCap
    ): BFPosition {
        abort 0
    }

    public fun update_market_active(
        protocol: &mut LendingProtocol,
        market_cap: &MarketCap,
        active: bool,
        clock: &Clock
    ) {
        abort 0
    }

    public fun create_position_for_partner(
        protocol: &mut LendingProtocol,
        partner_id: ID,
        ctx: &mut TxContext
    ): PositionCap {
        abort 0
    }

    public fun fulfill_promise<C>(
        protocol: &mut LendingProtocol,
        market_id: u64,
        position_cap: &PositionCap,
        promise: LiquidityPromise<C>,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<C> {
        abort 0
    }

    public fun fulfill_promise_SUI(
        protocol: &mut LendingProtocol,
        market_id: u64,
        position_cap: &PositionCap,
        promise: LiquidityPromise<SUI>,
        clock: &Clock,
        ctx: &mut TxContext
    ): Coin<SUI> {
        abort 0
    }
} 