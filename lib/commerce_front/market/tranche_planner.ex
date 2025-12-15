defmodule CommerceFront.Market.TranchePlanner do
  alias CommerceFront.Settings.{Asset, AssetTranche}
  alias CommerceFront.Repo
  import Ecto.Query
  require Decimal

  def next_tranche_price(%Asset{} = asset) do
    last =
      from(t in AssetTranche, where: t.asset_id == ^asset.id, order_by: [desc: t.seq], limit: 1)
      |> Repo.one()

    prev_price = (last && last.unit_price) || asset.base_price

    case asset.price_increment_type do
      :fixed_amount ->
        Decimal.add(prev_price, asset.price_increment_value)

      :percent ->
        Decimal.mult(prev_price, Decimal.add(Decimal.new("1"), asset.price_increment_value))
    end
  end

  def create_next_tranche(asset_id, quantity) do
    asset = Repo.get!(Asset, asset_id)
    price = next_tranche_price(asset)

    next_seq =
      (Repo.one(from(t in AssetTranche, where: t.asset_id == ^asset_id, select: max(t.seq))) || 0) +
        1

    %AssetTranche{}
    |> AssetTranche.changeset(%{
      asset_id: asset_id,
      seq: next_seq,
      quantity: quantity,
      unit_price: price,
      state: :open,
      released_at: DateTime.utc_now()
    })
    |> Repo.insert()
  end
end
