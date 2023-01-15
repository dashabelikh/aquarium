package io.prototype.aquarium.model;

public class AquariumModel {

	private int[] amounts;

	public int[] getAmounts() {
		return amounts;
	}

	public void setAmounts(int[] amounts) {
		this.amounts = amounts;
	}

	public AquariumModel() {
		super();
	}

	public AquariumModel(int[] amounts) {
		super();
		this.amounts = amounts;
	}

}
