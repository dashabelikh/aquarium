package aero.geoscan.aquarium;

import java.util.ArrayList;
import java.util.List;

public class AquariumModel {

	private List<Integer> amounts = new ArrayList<Integer>();
	private List<List<Cube>> cubes = new ArrayList<List<Cube>>();

	private String coordinates = "";

	public String calculateWater(int[] cubeAmmount) {

		if (cubeAmmount == null)
			return coordinates;

		// amounts.clear();

		for (int i : cubeAmmount)
			amounts.add(i);
		// System.out.print(i + " ");
		// System.out.print("\n");

		int maxX = amounts.size() - 1;// x изменяется от 0 до 4
		int maxY = amounts.stream().mapToInt(i -> i).max().getAsInt(); // y
																		// изменяется
																		// от 1
																		// до 3
		int currentX = 0;
		for (int amount : amounts) {

			List<Cube> list = new ArrayList<Cube>();
			for (int currentY = 0; currentY <= maxY; currentY++) {

				boolean isWaterproof = true;
				if (currentY > amount)
					isWaterproof = false;
				if (amount == 0)
					isWaterproof = false;

				list.add(new Cube(currentX, currentY, isWaterproof));
				// System.out.println(currentX + " " + currentY + " " +
				// isWaterproof);
			}
			cubes.add(list);
			currentX++;
		}

		for (List<Cube> it : cubes) {

			for (Cube itCube : it) {
				if (itCube.isWaterproof()) // пропускаем все водонепроницаемые
											// блоки
					continue;

				int x = itCube.getX();
				int y = itCube.getY();

				if (x == 0) // если блок первый слева, то он не
					// может быть
					// наполнен водой
					continue;

				int waterProofsX_Left = 0;

				boolean isLimited = true;

				// проверяем, есть ли ограничение слева
				for (int preX = x - 1; preX >= 0; preX--) {

					if (waterProofsX_Left == 1)
						break;

					waterProofsX_Left += (cubes.get(preX).get(itCube.getY()).isWaterproof()) ? 1 : 0;

					for (int preY = y - 1; preY >= 0; preY--) {
						if (cubes.get(preX).get(preY).isWaterproof()) {
							break;
						} else {
							isLimited = false;
						}

					}

				}

				if (!isLimited)
					waterProofsX_Left = 0;

				// проверяем, есть ли ограничение справа
				x = itCube.getX();

				int waterProofsX_Right = 0;
				while (x < amounts.size()) {
					if (waterProofsX_Right == 1)
						break;

					if (!cubes.get(x).get(0).isWaterproof())
						break;

					waterProofsX_Right += (cubes.get(x).get(itCube.getY()).isWaterproof()) ? 1 : 0;
					x++;
				}

				// проверяем, есть ли ограничение снизу
				isLimited = true;
				x = itCube.getX();
				y = itCube.getY();
				int waterProofsY = 0;

				for (int preY = y - 1; preY >= 0; preY--) {

					if (waterProofsY == 1)
						break;

					waterProofsY += (cubes.get(x).get(preY).isWaterproof()) ? 1 : 0;

					for (int prepreY = 0; prepreY < preY; prepreY++) {
						if (cubes.get(x).get(prepreY).isWaterproof()) {
							break;
						} else {
							isLimited = false;
						}

					}

				}

				if (!isLimited)
					waterProofsY = 0;

				if (!isLimited)
					waterProofsY = 0;

				boolean isWater = false;
				if (waterProofsX_Left == 1 && waterProofsX_Right == 1 && waterProofsY == 1)
					isWater = true;

				if (itCube.getX() == maxX)
					isWater = false;
				itCube.setWater(isWater);

				System.out.println(
						itCube.getX() + " " + itCube.getY() + " " + itCube.isWaterproof() + " " + itCube.isWater());

				if (isWater)
					coordinates += itCube.getX() + ";" + itCube.getY() + ";";

			}
		}

		return coordinates;

	}

}
