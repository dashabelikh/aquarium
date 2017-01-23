package aero.geoscan.aquarium;

/**
 * 
 * Single Cube
 * 
 * @author Daria
 *
 */
public class Cube {

	private int x; // column
	private int y; // row
	private boolean isWaterproofCube;
	private boolean isWater;

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

	public boolean isWaterproof() {
		return isWaterproofCube;
	}

	public void setWaterproof(boolean isWaterproof) {
		this.isWaterproofCube = isWaterproof;
	}

	public boolean isWater() {
		return isWater;
	}

	public void setWater(boolean isWater) {
		this.isWater = isWater;
	}

	public Cube(int x, int y, boolean isWaterproof) {
		super();
		this.x = x;
		this.y = y;
		this.isWaterproofCube = isWaterproof;
		this.isWater = false;
	}

}
