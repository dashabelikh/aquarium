package aero.geoscan.aquarium;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class AquariumService {
	public String getDesc() {

		return "AQUARIUM";

	}

	public String getTitle(String name) {

		if (StringUtils.isEmpty(name)) {
			return getDesc();
		} else {
			return "Hello, " + name + ". This is an " + getDesc();
		}

	}

	public String calculate(int[] amountOfCubes) {

		if (amountOfCubes == null)
			return "";

		return calculateWater(amountOfCubes);

	}

	private String calculateWater(int[] cubeAmmount) {

		String coordinates = "";

		if (cubeAmmount == null)
			return coordinates;

		List<Integer> amounts = new ArrayList<Integer>();
		List<List<Cube>> cubes = new ArrayList<List<Cube>>();

		for (int i : cubeAmmount)
			amounts.add(i);
		// System.out.print(i + " ");
		// System.out.print("\n");

		int maxX = amounts.size() - 1;// x изменяется от 0 до 4
		int maxY = amounts.stream().mapToInt(i -> i).max().getAsInt(); // y
																		// изменяется
																		// от
																		// 1
																		// до
																		// 3
		int currentX = 0;
		for (int amount : amounts) {

			List<Cube> list = new ArrayList<Cube>();
			for (int currentY = 1; currentY <= maxY; currentY++) {

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
					if (!cubes.get(preX).get(0).isWaterproof()) {
						isLimited = false;
						break;
					}
					waterProofsX_Left += (cubes.get(preX).get(itCube.getY() - 1).isWaterproof()) ? 1 : 0;
					for (int preY = y - 1; preY >= 1; preY--) {

						if (cubes.get(preX).get(preY - 1).isWaterproof()) {
							isLimited = true;
							break;
						} else {
							isLimited = false;
						}
					}
				}

				if (!isLimited)
					waterProofsX_Left = 0;

				// проверяем, есть ли ограничение справа
				int waterProofsX_Right = 0;
				isLimited = true;
				x = itCube.getX();

				for (int postX = x + 1; postX <= maxX; postX++) {
					if (waterProofsX_Right == 1)
						break;
					if (!cubes.get(postX).get(0).isWaterproof()) {
						isLimited = false;
						break;
					}
					waterProofsX_Right += (cubes.get(postX).get(itCube.getY() - 1).isWaterproof()) ? 1 : 0;
					// for (int postY = y + 1; postY < maxY; postY++) {
					for (int preY = y - 1; preY >= 1; preY--) {

						if (cubes.get(postX).get(preY).isWaterproof()) {
							isLimited = true;
							break;
						} else {
							isLimited = false;
						}
					}
				}

				if (!isLimited)
					waterProofsX_Right = 0;

				// проверяем, есть ли ограничение снизу
				isLimited = true;
				x = itCube.getX();
				y = itCube.getY();
				int waterProofsY = 0;

				for (int preY = y - 1; preY >= 1; preY--) {

					if (waterProofsY == 1)
						break;

					waterProofsY += (cubes.get(x).get(preY - 1).isWaterproof()) ? 1 : 0;

					for (int prepreY = 1; prepreY < preY; prepreY++) {
						if (cubes.get(x).get(prepreY - 1).isWaterproof()) {
							break;
						} else {
							isLimited = false;
						}
					}
				}

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
